class OverviewPage
  constructor: (id)->
    @page = window.structure.pages[id]
    infoElements = @page.getElementsByClassName "info"
    moduleElements = @page.getElementsByClassName("modules-container")[0].children
    @activeElement = null
    moduleElements[0].addEventListener "click", ()=>
      window.structure.goToPrevPage()
    moduleElements[1].addEventListener "click", ()=>
      window.structure.goToNextPage()
    infoElements.forEach (infoElement)=>
      infoElement.addEventListener "click", ()=>
        @setActive infoElement
    @addModuleElementsEventListener(moduleElements, ['goToPrevPage', 'goToNextPage'])
    @addExitEventListener([window.structure.menuBack, window.structure.menuNext])

  disableActive: ()->
    @activeElement?.classList.remove "active"
    @activeElement = null

  setActive: (tappedElement)->
    unless tappedElement.classList.contains "active"
      do @disableActive
      tappedElement.classList.add "active"
      @activeElement = tappedElement

  addModuleElementsEventListener: (moduleElements, methods)->
    moduleElements.forEach (moduleElement, index) =>
      moduleElement.addEventListener 'click', ()=>
        @[methods[index]]()

  addExitEventListener: (menuButtons)->
    menuButtons.forEach (menuButton) =>
      menuButton.addEventListener 'click', ()=>
        do @disableActive

overviewPage = new OverviewPage('overview')