# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'chips', 100


  newGame: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  logic: ->
    dealerHand = @get('dealerHand').scores()
    # debugger
    if dealerHand <= 16
      console.log ("dealer hits")
      @get('dealerHand').hit()
      @logic
    else
      @isBusted()
      @scoreEval()

  isBusted: ->
    if @get('playerHand').scores() > 21
      console.log ("Player busts")
      @get('playerHand').hasBusted = true

    else
      if @get('dealerHand').scores() > 21
        console.log ("Dealer busts")
        @get('dealerHand').hasBusted = true

  scoreEval: ->
    if @get('playerHand').hasBusted
      console.log ("...Dealer Wins")
      @set 'chips', 0
    else
      if @get('dealerHand').hasBusted
        console.log ("...Player Wins")
        @set 'chips', (@get 'chips') + 100
      else
        if @get('playerHand').scores() > @get('dealerHand').scores()
          console.log ("Player wins")
          @set 'chips', (@get 'chips') + 100
        else
          if @get('playerHand').scores() == @get('dealerHand').scores()
            console.log ("Draw, game over")
          else
            console.log ("Dealer wins")
            @set 'chips', (@get 'chips') + 100

