class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @checkBust()
    'click .stand-button': -> @func()


  func: ->
    @model.get('dealerHand').stand()
    @model.logic()
    @render()
    that = @
    @$el.append('<div class="reset">"Text"</div>')
    `$('div').on('click', '.reset', function() {
    that.model.newGame();
    that.render();
    });`

  checkBust: ->
    @model.get('playerHand').hit()
    @model.isBusted()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

