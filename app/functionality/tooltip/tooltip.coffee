class Tooltip
  constructor: (tooltip, page) ->
    @tooltip = tooltip
    @page = page
    @openAttribute = 'data-tooltip'
    do @addCloseHandler
    @initialise()

  addCloseHandler: () ->
    closeArea = document.body
    closeArea.addEventListener('tap', ()=>
      unless(@tooltip.contains(event.target) or @isActiveTooltipButton(event.target))
        do @hide
    , true)


  initialise: () ->
    if @page.getElementsByClassName(@openAttribute).length
      openButton = @page.getElementsByClassName(@props.open)[0]
      openButton.addEventListener 'tap', ()=>
        do @show
      true
    else
      false

  isActiveTooltipButton: (element) ->
    element.classList.contains(@openAttribute) and element.classList.contains("active")

  show: () ->
    @openButton = event.target
    if @isActiveTooltipButton(@openButton)
      @hide()
      event.stopPropagation()
    else
      @openButton.classList.add "active"
      @tooltip.classList.add 'show'

  hide: () ->
    if @openButton then @openButton.classList.remove "active"
    @openButton = null
    @tooltip.classList.remove 'show'

window.Tooltip = Tooltip