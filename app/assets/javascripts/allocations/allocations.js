// disable Moderinizr for now... need to sort out asset compilation

// if (Modernizr.draganddrop) {
  // Browser supports HTML5 DnD.

  function createAllocation(task_id, person_id) {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/allocations', true);
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhr.onload = function(e) {
      if (this.status == 200) {
        var updated_allocations = JSON.parse(this.responseText);
        elem = jQuery("ul#people [data-id="+updated_allocations.person_id+"] ul.allocations");
        var html = "";
        for (var a in updated_allocations.allocations) {
          html += "<li class='allocation'><span class='allocation' data-id='" + updated_allocations.allocations[a].id + "'>";
          html += updated_allocations.allocations[a].name.substr(0, 40);
          html += "</span></li>";
        }
        jQuery(elem).html(html);
        jQuery(elem).find('span').bind('click', deleteAllocation);
      }
    };
    current_event_id = jQuery('ul#events li.active').attr('data-id');
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
            $(elem).parent().remove();
          }
        });
        return false;
      } else {
        return false;
      }
    }

  // another bit of jquery blah-ness
  jQuery(function($) { // document ready
    $('ul.allocations span').bind('click', deleteAllocation);
    $('ul#tasks li').draggable({
      opacity: 0.7, helper: "clone",
      appendTo: "body"
    });
    $( "div.person" ).droppable({
      activeClass: "ui-state-default",
      hoverClass: "ui-state-hover",
      accept: ":not(.ui-sortable-helper)",
      drop: function( event, ui ) {
        $( "<li class='allocation'></li>" ).text( ui.draggable.text() ).appendTo( $( this ).parent().find("allocations") );
        task_id = ui.draggable.find("span").attr("data-id");
        person_id = $( this ).parent().get(0).getAttribute('data-id');
        createAllocation(task_id, person_id);
      }
    });
  });

// } else {
  // Fallback to a library solution for drag and drop.
// }