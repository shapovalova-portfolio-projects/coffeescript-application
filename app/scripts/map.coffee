class MapPage extends Page
  constructor: (id)->
    super id
    @firstStep = 'step0'
    @stepsStackDomElement = @page.getElementsByClassName('steps-stack')[0]
    @addAllElementsWithClassEventListener(['next', 'back'], [@goToNextStep, @goToPreviousStep])
    @addExitEventListener @resetToInitial
    @history = window.History
    @history.getAllStepsData(id)
    @changeStepTo @firstStep

  checkMode: ()->
    unless @page.classList.contains "steps-mode" then @page.classList.add "steps-mode"

  resetToInitial: ()=>
    @history.clear()
    do @goToFirstStep
    @page.classList.remove "steps-mode"

  clearStepsStackElement: ()->
    @stepsStackDomElement.classList.remove("single-step")
    @stepsStackDomElement.innerHTML = ''

  createHeader2: (text)->
    header2 = document.createElement 'h2'
    header2.innerHTML = text
    header2

  createButton: (dataAttributeValue)->
    backButton = document.createElement 'button'
    backButton.setAttribute('data-goto-step', dataAttributeValue)
    backButton.classList.add 'arrow'
    backButton.classList.add 'back'
    backButton.addEventListener 'click', ()=>
      @goToPreviousStep()
      event.preventDefault()
    backButton

  createParagraph: (text)->
    paragraph = document.createElement 'p'
    paragraph.innerHTML = text
    paragraph

  createList: (list)->
    blocksList = document.createElement 'ul'
    list.forEach (item)=>
      listItem = document.createElement 'li'
      listItem.innerHTML = item
      blocksList.appendChild listItem
    blocksList

  createDiv: (blocksContent)->
    blocks = document.createElement 'div'
    if blocksContent.description
      blocks.appendChild @createParagraph(blocksContent.description)
    if blocksContent.blocks_list
      blocks.appendChild @createList(blocksContent.blocks_list)
    blocks

  createStepElement: (step, isCurrentStep = false)->
    if step.data
      stepData = step.data.introduction
      stepDiv = document.createElement 'div'
      stepDiv.appendChild @createButton(step.id)
      stepDiv.appendChild @createHeader2(stepData.caption)
      if isCurrentStep
        if stepData.text
          stepData.text.forEach (paragraph)=>
            stepDiv.appendChild @createParagraph(paragraph)
        if stepData.blocks
          stepDiv.appendChild @createDiv(stepData.blocks)
      stepDiv
    else
      null

  updateStepsStack: ()->
    @clearStepsStackElement()
    @history.steps.forEach (step)=>
      stepElement = @createStepElement step, @history.isCurrentStep(step)
      @stepsStackDomElement.appendChild stepElement
    if @history.steps.length is 1 then @stepsStackDomElement.classList.add("single-step")

  goToFirstStep: ()->
    @changeStepTo @firstStep

  goToStep: (step)->
    if step
      @changeStepTo step
      @updateStepsStack()
      @checkMode()

  goToNextStep: ()=>
    step = event.target.attributes['data-goto-step']?.value
    unless step
      buttonIndex = event.target.attributes['data-button-index']?.value
      step = @history.currentStep.next[buttonIndex]
    @history.stepNext step
    @goToStep step

  goToPreviousStep: ()=>
    step = event.target.attributes['data-goto-step']?.value
    if !step or step is @history.steps[0].id
      @resetToInitial()
    else
      step = @history.stepBack(step).id
      @goToStep step

  changeStepTo: (step)->
    @page.classList.remove @page.currentStep
    @page.classList.add step
    @page.currentStep = step


mapPage = new MapPage('map')