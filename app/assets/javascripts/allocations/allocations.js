if (Modernizr.draganddrop) {
  // Browser supports HTML5 DnD.
  // console.log('yay..!');


  var dragSrcEl = null;

  function handleDragStart(e) {
    this.style.opacity = '0.4';  // this / e.target is the source node.
  
    dragSrcEl = this;

    e.dataTransfer.effectAllowed = 'move';
    e.dataTransfer.setData('text/html', this.innerHTML); // the data payload is set to the actual HTML of the source column
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

  function handleDrop(e) {
    // this / e.target is current target element.
    if (e.stopPropagation) {
      e.stopPropagation(); // stops the browser from redirecting.
    }

    // See the section on the DataTransfer object.
    if (dragSrcEl != this) {
      // Set the source column's HTML to the HTML of the column we dropped on.
      dragSrcEl.innerHTML = this.innerHTML;
      this.innerHTML = e.dataTransfer.getData('text/html');
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