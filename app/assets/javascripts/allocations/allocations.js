// disable Moderinizr for now... need to sort out asset compilation

// if (Modernizr.draganddrop) {
  // Browser supports HTML5 DnD.

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

  function handleDrop(e) {
    // this / e.target is current target element.
    if (e.stopPropagation) {
      e.stopPropagation(); // stops the browser from redirecting.
    }

    // See the section on the DataTransfer object.
    if (dragSrcEl != this && dragSrcEl.parentNode.parentNode.id === 'tasks' && this.parentNode.parentNode.id === 'people') {
      task_id = e.dataTransfer.getData('application/json');
      person_id = this.parentNode.getAttribute('data-id');

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
          node: $(this)[0].parentNode,
          success: function() {
            // seriously should to be a better way to do this....
            $(this)[0].node.remove();
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
  });

// } else {
  // Fallback to a library solution for drag and drop.
// }