class Page
  constructor: (id)->
    @page = window.structure.pages[id]
    @elements = {};

  getElementsOnce: (elementsArray)->
    elementsArray.forEach (element)=>
      @elements[element] = @page.getElementsByClassName element

  addAllElementsWithClassEventListener: (elements, methods)->
    elements.forEach (elementClass, index) =>
      domElements = @page.getElementsByClassName(elementClass)
      domElements.forEach (domElement) =>
        domElement.addEventListener 'click', ()=>
          methods[index](domElement)

  addElementsEventListener: (elements, methods)->
    elements.forEach (element, index) =>
      element.addEventListener 'click', ()=>
        methods[index](element)

  addExitEventListener: (reset)->
    [window.structure.menuBack, window.structure.menuNext].forEach (menuButton) =>
      menuButton.addEventListener 'click', ()=>
        reset()