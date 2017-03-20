class Page
  constructor: (id)->
    @page = document.getElementById id
    @elements = {};

  getElementsOnce: (elementsArray)->
    elementsArray.forEach (element)=>
      @elements[element] = @page.getElementsByClassName element

class Structure
  constructor: ()->
    @pages = document.getElementById('pages').getElementsByClassName 'page'
    menu = document.getElementById('menu')
    @menuBack = menu.getElementsByClassName('back')[0]
    @menuNext = menu.getElementsByClassName('next')[0]
    @addMenuButtonsHandler menu
    do @setFirstPageActive

  addMenuButtonsHandler: (menu)->
    @menuBack.addEventListener 'click', =>
      @goToPage window.currentSlideIndex-1
    @menuNext.addEventListener 'click', =>
      @goToPage window.currentSlideIndex+1

  checkMenuButtons: ()->
    @menuBack.classList.remove 'hidden'
    @menuNext.classList.remove 'hidden'
    if window.currentSlideIndex is 0
      @menuBack.classList.add 'hidden'
    else if window.currentSlideIndex is @pages.length-1
      @menuNext.classList.add 'hidden'

  goToPage: (index)->
    @pages[window.currentSlideIndex].classList.remove 'active'
    @pages[index].classList.add 'active'
    window.currentSlideIndex = index
    @checkMenuButtons()

  setFirstPageActive: () ->
    window.currentSlideIndex = 0
    @goToPage 0

window.structure = new Structure();