if (Modernizr.draganddrop) {
  // Browser supports HTML5 DnD.
  // console.log('yay..!');

  var dragSrcEl = null;

  function handleDragStart(e) {
    this.style.opacity = '0.4';  // this / e.target is the source node.
  
    dragSrcEl = this;

    e.dataTransfer.effectAllowed = 'move';
    e.dataTransfer.setData('application/json', this.getAttribute('data-id')); // the data payload is set to the actual HTML of the source column
  }

  function handleDragEnter(e) {
    // this / e.target is the current hover target.
    if (this.parentNode.parentNode.id === 'people') {
      this.classList.add('over');
    }
  }

  function handleDragOver(e) {
    if (e.preventDefault) {
      e.preventDefault(); // Necessary. Allows us to drop.
    }
    e.dataTransfer.dropEffect = 'move';  // See the section on the DataTransfer object.
    return false;
  }

  function handleDragLeave(e) {
    this.classList.remove('over');  // this / e.target is previous target element.
  }

  function wow(e) {
    console.log('jeeeezuz...');
  }

  function createAllocation(task_id, person_id) {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/allocations', true);
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhr.onload = function(e) {
      if (this.status == 200) {
        // nasty dom update to follow...
        elem = document.getElementById('allocations');
        var updated_allocations = JSON.parse(this.responseText);
        var html = "";
        for (var a in updated_allocations) {
          html += "<li><span class='dnd-node' data-id='" + updated_allocations[a].id + "'>";
          html += updated_allocations[a].person_id + "<->" + updated_allocations[a].task_id;
          html += "</span></li>";
        }
        elem.innerHTML = html;

        // bit of jquery blah...
        jQuery('ul#allocations .dnd-node').bind('click', deleteAllocation);

      }
    };
    current_event_id = document.getElementById('event').getAttribute('data-id');
    xhr.send(JSON.stringify({id: current_event_id, allocation: {task_id: task_id, person_id: person_id}}));
  }

  function handleDrop(e) {
    // this / e.target is current target element.
    if (e.stopPropagation) {
      e.stopPropagation(); // stops the browser from redirecting.
    }

    // See the section on the DataTransfer object.
    if (dragSrcEl != this && dragSrcEl.parentNode.parentNode.id === 'tasks' && this.parentNode.parentNode.id === 'people') {
      task_id = e.dataTransfer.getData('application/json');
      person_id = this.getAttribute('data-id');

      createAllocation(task_id, person_id);
    }
    return false;
  }

  function handleDragEnd(e) {
    // this/e.target is the source node.

    [].forEach.call(nodes, function (node) {
      node.classList.remove('over');
      node.style.opacity = '1.0';
    });
  }

  var nodes = document.querySelectorAll('.dnd-node');
  [].forEach.call(nodes, function(node) {
    node.addEventListener('dragstart', handleDragStart, false);
    node.addEventListener('dragenter', handleDragEnter, false);
    node.addEventListener('dragover', handleDragOver, false);
    node.addEventListener('dragleave', handleDragLeave, false);
    node.addEventListener('drop', handleDrop, false);
    node.addEventListener('dragend', handleDragEnd, false);
  });

  function deleteAllocation(e){
      if(confirm("Are you sure?")){
        $.ajax({
          url: '/allocations/' + $(this)[0].getAttribute('data-id'),
          type: 'post',
          dataType: 'script',
          data: { '_method': 'delete' },
          node: $(this),
          success: function() {
            // seriously should to be a better way to do this....
            $(this)[0].node[0].remove();
          }
        });
        return false;
      } else {
        return false;
      }
    }

  // another bit of jquery blah-ness
  jQuery(function($) { // document ready
    $('ul#allocations .dnd-node').bind('click', deleteAllocation);
  });

} else {
  // Fallback to a library solution for drag and drop.
}