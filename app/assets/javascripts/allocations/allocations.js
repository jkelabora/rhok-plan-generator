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
    this.classList.add('over');
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
        // nasty dom update to follow...
        elem = document.getElementById('allocations');
        var updated_allocations = JSON.parse(this.responseText);
        var html = "";
        for (var a in updated_allocations) {
          html += "<div class='column' draggable='true'>";
          html += "<header>Allocation p<->t</header>";
          html += updated_allocations[a].person_id + "<->" + updated_allocations[a].task_id;
          html += "</div>";
        }
        elem.innerHTML = html;
      }
    };
    xhr.send(JSON.stringify({allocation: {task_id: task_id, person_id: person_id}}));
  }

  function handleDrop(e) {
    // this / e.target is current target element.
    if (e.stopPropagation) {
      e.stopPropagation(); // stops the browser from redirecting.
    }

    // See the section on the DataTransfer object.
    if (dragSrcEl != this && dragSrcEl.parentNode.id === 'tasks' && this.parentNode.id === 'people') {
      task_id = e.dataTransfer.getData('application/json');
      person_id = this.getAttribute('data-id');

      createAllocation(task_id, person_id);
    }
    return false;
  }

  function handleDragEnd(e) {
    // this/e.target is the source node.

    [].forEach.call(cols, function (col) {
      col.classList.remove('over');
      col.style.opacity = '1.0';
    });
  }



  var cols = document.querySelectorAll('.column');
  [].forEach.call(cols, function(col) {
    col.addEventListener('dragstart', handleDragStart, false);
    col.addEventListener('dragenter', handleDragEnter, false);
    col.addEventListener('dragover', handleDragOver, false);
    col.addEventListener('dragleave', handleDragLeave, false);
    col.addEventListener('drop', handleDrop, false);
    col.addEventListener('dragend', handleDragEnd, false);
  });


} else {
  // Fallback to a library solution.
  // console.log('nay...');
}