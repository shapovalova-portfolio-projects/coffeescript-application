class OverviewPage
  constructor: (id)->
    @page = window.structure.pages[id]
    infoElements = @page.getElementsByClassName "info"
    @activeElement = null
    debugger
    infoElements.forEach (infoElement)=>
      infoElement.addEventListener "click", ()=>
        @setActive infoElement
#
#  onExit: (element)->
#    do @disableActive

  disableActive: ()->
    @activeElement?.classList.remove "active"
    @activeElement = null

  setActive: (tappedElement)->
    unless tappedElement.classList.contains "active"
      do @disableActive
      tappedElement.classList.add "active"
      @activeElement = tappedElement

overviewPage = new OverviewPage('overview')