class OverviewPage extends Page
  constructor: (id)->
    super id
    moduleElements = @page.getElementsByClassName("modules-container")[0].children
    @activeElement = null
    @addAllElementsWithClassEventListener ["info"], [@setActive]
    @addElementsEventListener moduleElements, [@goToPage, @goToPage]
    @addExitEventListener @disableActive

  disableActive: ()=>
    @activeElement?.classList.remove "active"
    @activeElement = null

  setActive: (tappedElement)=>
    unless tappedElement.classList.contains "active"
      do @disableActive
      tappedElement.classList.add "active"
      @activeElement = tappedElement

  goToPage: (element)->
    pageId = element.attributes['data-page'].value
    index = window.structure.getPageIndexById pageId
    window.structure.goToPage index

overviewPage = new OverviewPage('overview')