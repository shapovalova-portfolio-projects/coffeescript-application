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
      @goToPrevPage()
    @menuNext.addEventListener 'click', =>
      @goToNextPage()

  checkMenuButtons: ()->
    @menuBack.classList.remove 'hidden'
    @menuNext.classList.remove 'hidden'
    if window.currentSlideIndex is 0
      @menuBack.classList.add 'hidden'
    else if window.currentSlideIndex is @pages.length-1
      @menuNext.classList.add 'hidden'

  goToPrevPage: ()->
    if window.currentSlideIndex isnt 0
      @goToPage window.currentSlideIndex-1

  goToNextPage: ()->
    if window.currentSlideIndex isnt @pages.length-1
      @goToPage window.currentSlideIndex+1

  goToPage: (index)->
    @pages[window.currentSlideIndex].classList.remove 'active'
    @pages[index].classList.add 'active'
    window.currentSlideIndex = index
    @checkMenuButtons()

  setFirstPageActive: () ->
    window.currentSlideIndex = 0
    @goToPage 0

  getPageIndexById: (id) ->
    i = 0
    for page in @pages
      return i if page.id == id
      i++
    return -1
