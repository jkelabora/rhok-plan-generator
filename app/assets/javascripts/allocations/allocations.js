
function createAllocation(task_id, person_id) {
  var xhr = new XMLHttpRequest();
  xhr.open('POST', '/allocations', true);
  xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
  xhr.onload = function(e) {
    if (this.status == 200) {
      var resp = JSON.parse(this.responseText);
      var position = $('table#allocations tbody > tr').length;
      var html = ""
        html +="<tr>";
        html +=  "<td class='allocation-signature'><h4>"+paddedPosition(position)+"</h4></td>"
        html +=  "<td>"+resp.task_name+"</td>";
        html +=  "<td class='allocation-delete' data-id="+resp.allocation_id+"><i class='fi-x'></i></td>"
        html +="</tr>"
      $( html ).appendTo( $( "table#allocations") );

      $('table#allocations').find('tr#add-row').appendTo('table#allocations'); // move the Add to the end of the list..
      $('td#add').text('Click here to add your own task'); // work-around bad binding

      $("td.allocation-delete[data-id='"+resp.allocation_id+"']").bind('click', deleteAllocation);
    }
  };
  current_event_id = $('dl.sub-nav dd.active').attr('data-id');
  xhr.send(JSON.stringify({id: current_event_id, allocation: {task_id: task_id, person_id: person_id}}));
}

function deleteAllocation(e){
  var elem = this;
  if(confirm("Are you sure you want to delete this task?")){
    $.ajax({
      url: '/allocations/' + elem.getAttribute('data-id'),
      type: 'post',
      dataType: 'script',
      data: { '_method': 'delete' },
      success: function() {
        $(elem.parentNode).remove();
        updateTaskNumbering();
      }
    });
    return false;
  } else {
    return false;
  }
}

function paddedPosition(position) {
  return position.toString().length === 1 ? '0' + position : position;
}

function updateTaskNumbering() {
  $('td.allocation-signature h4').each(function( index ) {
    $( this ).text(paddedPosition(index + 1));
  });
}


$(function($) { // document ready

  // START: http://www.appelsiini.net/projects/jeditable
  plan_private_guid = $( "span#private-guid" ).attr('data-id');
  var update_plan_endpoint = '/plans/private/'+plan_private_guid+'/update';
  $('.edit#name').editable(update_plan_endpoint, {
    indicator : 'Saving...',
    name      : 'name'
  });

  $('.edit#postcode').editable(update_plan_endpoint, {
    indicator : 'Saving...',
    name      : 'postcode'
  });

  $('.edit#add').editable('/allocations', {
    indicator  : 'Saving...',
    name       : 'name',
    data       : ' ', // empty string doesn't work unfortunately
    submitdata : function(value, settings) {
      var person_id = $('span#person-id').attr('data-id');
      var event_id  = $('dl.sub-nav dd.active').attr('data-id');
      return {person_id: person_id, event_id: event_id};
    },
    callback : function(value, settings) {
      var resp = JSON.parse(value);

      var position = $('table#allocations tbody > tr').length.toString();
      var padded_position = position.length === 1 ? '0' + position : position;
      var html = ""
        html +="<tr>";
        html +=  "<td class='allocation-signature'><h4>"+padded_position+"</h4></td>"
        html +=  "<td>"+resp.task_name+"</td>";
        html +=  "<td class='allocation-delete' data-id="+resp.allocation_id+"><i class='fi-x'></i></td>"
        html +="</tr>"
      $( html ).appendTo( $( "table#allocations") );

      $('table#allocations').find('tr#add-row').appendTo('table#allocations'); // move the Add to the end of the list..
      $('td#add').text('Click here to add your own task'); // work-around bad binding

      $("td.allocation-delete[data-id='"+resp.allocation_id+"']").bind('click', deleteAllocation);
     }
  });
  // END

  $('td.allocation-delete').bind('click', deleteAllocation);

  $('table#tasks td.red-margin').draggable({
    opacity: 0.7,
    cursor: "pointer",
    cursorAt: { top: 0, left: 0 },
    helper: function() { return $(this.parentElement).find('td.suggested').clone()[0]; }
  });

  $( "table#allocations" ).droppable({
    activeClass: "ui-state-highlight",
    hoverClass: "ui-state-hover",
    accept: "table#tasks td.red-margin",
    tolerance: 'pointer',
    drop: function( event, ui ) {
      task_id = ui.helper.attr("data-id");
      person_id = $( "span#person-id" ).attr('data-id');
      createAllocation(task_id, person_id);
    }
  });
});
