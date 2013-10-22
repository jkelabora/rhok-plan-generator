
function createAllocation(task_id, person_id) {
  var xhr = new XMLHttpRequest();
  xhr.open('POST', '/allocations', true);
  xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
  xhr.onload = function(e) {
    if (this.status == 200) {
      var updated_allocations = JSON.parse(this.responseText);
      elem = $("ul#allocations");
      var html = "";
      for (var a in updated_allocations.allocations) {
        html += "<li class='allocation' data-id='" + updated_allocations.allocations[a].id + "'>";
        html += updated_allocations.allocations[a].name;
        html += "</li>";
      }
      $(elem).html(html);
      $(elem).find('li').bind('click', deleteAllocation);
    }
  };
  current_event_id = $('ul#events li.active').attr('data-id');
  xhr.send(JSON.stringify({id: current_event_id, allocation: {task_id: task_id, person_id: person_id}}));
}

function deleteAllocation(e){
    var elem = this;
    if(confirm("Are you sure?")){
      $.ajax({
        url: '/allocations/' + elem.getAttribute('data-id'),
        type: 'post',
        dataType: 'script',
        data: { '_method': 'delete' },
        success: function() {
          $(elem).remove();
        }
      });
      return false;
    } else {
      return false;
    }
  }

$(function($) { // document ready
  $('ul#allocations li').bind('click', deleteAllocation);
  $('ul#tasks li').draggable({
    opacity: 0.7, helper: "clone",
    appendTo: "body"
  });

  $( "ul#allocations" ).droppable({
    activeClass: "ui-state-default",
    hoverClass: "ui-state-hover",
    accept: ":not(.ui-sortable-helper)",
    drop: function( event, ui ) {
      task_id = ui.draggable.attr("data-id");
      $( "<li class='allocation' data-id="+task_id+" ></li>" ).text( ui.draggable.text() ).appendTo( $( "ul#allocations") );
      person_id = $( "span.person" ).attr('data-id');
      createAllocation(task_id, person_id);
    }
  });
});
