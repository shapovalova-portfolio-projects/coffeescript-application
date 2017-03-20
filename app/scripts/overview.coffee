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
    window.structure.menuBack.addEventListener "click", ()=>
      do @disableActive
    window.structure.menuNext.addEventListener "click", ()=>
      do @disableActive

  disableActive: ()->
    @activeElement?.classList.remove "active"
    @activeElement = null

  setActive: (tappedElement)->
    unless tappedElement.classList.contains "active"
      do @disableActive
      tappedElement.classList.add "active"
      @activeElement = tappedElement

overviewPage = new OverviewPage('overview')