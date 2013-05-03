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
//TODO: elem. ---->  add on click event to all children
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

// ////////////////////////////////////////////////////

  function destroyAllocation(allocation_id) {

    jQuery.ajax({

      // The 'type' property sets the HTTP method.
      // A value of 'PUT' or 'DELETE' will trigger a preflight request.
      type: 'DELETE',

      // The URL to make the request to.
      url: '/allocations/' + allocation_id,

      // The 'contentType' property sets the 'Content-Type' header.
      // The JQuery default for this property is
      // 'application/x-www-form-urlencoded; charset=UTF-8', which does not trigger
      // a preflight. If you set this value to anything other than
      // application/x-www-form-urlencoded, multipart/form-data, or text/plain,
      // you will trigger a preflight request.
      // contentType: 'text/plain',

      xhrFields: {
        // The 'xhrFields' property sets additional fields on the XMLHttpRequest.
        // This can be used to set the 'withCredentials' property.
        // Set the value to 'true' if you'd like to pass cookies to the server.
        // If this is enabled, your server must respond with the header
        // 'Access-Control-Allow-Credentials: true'.
        withCredentials: false 
      },

      headers: {
        // Set any custom headers here.
        // If you set any non-simple headers, your server must include these
        // headers in the 'Access-Control-Allow-Headers' response header.
      },

      success: function() {
        console.log('success');
        // Here's where you handle a successful response.
      },

      error: function() {
        console.log('error');
        // Here's where you handle an error response.
        // Note that if the error was due to a CORS issue,
        // this function will still fire, but there won't be any additional
        // information about the error.
      }
    });
  }



} else {
  // Fallback to a library solution.
  // console.log('nay...');
}