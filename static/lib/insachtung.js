// Generated by CoffeeScript 1.4.0
(function() {
  var Bitmap, Bonus, Controller, CrashController, NoWall, Painter, Player, PlayerInstance, Round, controller,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bitmap = (function() {

    function Bitmap(width, height, boundariesWidth) {
      this.width = width;
      this.height = height;
      this.boundariesWidth = boundariesWidth;
      this.bitmap = new Array(this.width * this.height);
    }

    return Bitmap;

  })();

  Painter = (function() {

    function Painter(bitmap) {
      this.bitmap = bitmap;
      this.canvas = document.getElementById("canvas");
      this.context = this.canvas.getContext('2d');
    }

    Painter.prototype.paintPlayer = function(player) {
      if (!Bonus.listContainsBonus(player.bonuses, NoWall)) {
        this.context.beginPath();
        this.context.strokeStyle = player["static"].color;
        this.context.lineWidth = player.size;
        this.context.moveTo(player.lastPos.x, player.lastPos.y);
        this.context.lineTo(player.pos.x, player.pos.y);
        this.context.closePath();
        return this.context.stroke();
      }
    };

    Painter.prototype.paintBonus = function(bonus) {};

    Painter.prototype.paintBoundaries = function() {
      this.context.strokeStyle = "yellow";
      this.context.lineWidth = this.bitmap.boundariesWidth;
      return this.context.strokeRect(0, 0, this.bitmap.width, this.bitmap.height);
    };

    Painter.prototype.paintUI = function() {};

    Painter.prototype.clearBoard = function() {
      return this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
    };

    return Painter;

  })();

  Bonus = (function() {

    function Bonus(duration) {
      this.duration = duration;
    }

    Bonus.prototype.play = function(player) {};

    Bonus.listContainsBonus = function(bonusList, bonusClass) {
      var bonus, _i, _len;
      for (_i = 0, _len = bonusList.length; _i < _len; _i++) {
        bonus = bonusList[_i];
        if (bonus instanceof bonusClass) {
          return true;
        }
      }
      return false;
    };

    return Bonus;

  })();

  NoWall = (function(_super) {

    __extends(NoWall, _super);

    function NoWall() {
      return NoWall.__super__.constructor.apply(this, arguments);
    }

    NoWall.prototype.play = function(player) {
      return this.duration -= 1;
    };

    return NoWall;

  })(Bonus);

  Round = (function() {

    function Round(controller) {
      var player, _i, _len, _ref;
      this.controller = controller;
      this.isOver = false;
      this.alivePlayers = [];
      _ref = this.controller.players;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        player = _ref[_i];
        this.alivePlayers.push(new PlayerInstance(player));
      }
      this.controller.crashController.setActiveRound(this);
    }

    Round.prototype.launch = function() {
      var delay, main,
        _this = this;
      this.controller.painter.clearBoard();
      this.controller.painter.paintBoundaries();
      delay = 1 / 30;
      main = function() {
        var player, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _results;
        if (!_this.isOver) {
          setTimeout(main, delay);
          _ref = _this.alivePlayers;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            player = _ref[_i];
            if ((Math.random() * 10) < 0.015) {
              player.bonuses.push(new NoWall(25));
            }
            player.play();
          }
          _ref1 = _this.alivePlayers;
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            player = _ref1[_j];
            _this.controller.crashController.checkForCrashes(player);
          }
          _ref2 = _this.alivePlayers;
          _results = [];
          for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
            player = _ref2[_k];
            _results.push(_this.controller.painter.paintPlayer(player));
          }
          return _results;
        }
      };
      return setTimeout(main, delay);
    };

    Round.prototype.notifyPlayerDeath = function(deadPlayer) {
      var p, player, tmp, _i, _j, _len, _len1, _ref, _ref1;
      _ref = this.alivePlayers;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        player = _ref[_i];
        if (player !== deadPlayer) {
          player["static"].score += 1;
        } else {
          tmp = new Array();
          _ref1 = this.alivePlayers;
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            p = _ref1[_j];
            if (p === deadPlayer) {
              tmp.push(p);
            }
          }
          this.alivePlayers = tmp;
        }
      }
      if (this.alivePlayers.length === 1) {
        this.isOver = true;
        return this.controller.notifyRoundIsDone();
      }
    };

    return Round;

  })();

  Player = (function() {

    Player.score = 0;

    function Player(name, color, keys) {
      this.name = name;
      this.color = color;
      this.keys = keys;
    }

    return Player;

  })();

  PlayerInstance = (function() {

    function PlayerInstance(_static) {
      var _this = this;
      this["static"] = _static;
      this.pos = {
        x: Math.floor((Math.random() * 700) + 100),
        y: Math.floor((Math.random() * 700) + 100)
      };
      this.lastPos = {
        x: void 0,
        y: void 0
      };
      this.radius = 1;
      this.course = Math.floor((Math.random() * 2 * Math.PI) + 0);
      this.size = 5;
      this.bonuses = [];
      this.keysPressed = [false, false];
      this.lastKeyPressed = "none";
      document.onkeydown = function(event) {
        if (event.keyCode === _this.player.keys[0]) {
          _this.lastKeyPressed = "left";
          return _this.keysPressed[0] = true;
        } else if (event.keyCode === _this.player.keys[1]) {
          _this.lastKeyPressed = "right";
          return _this.keysPressed[1] = true;
        }
      };
      document.onkeyup = function(event) {
        if (event.keyCode === _this.player.keys[0]) {
          _this.keysPressed[0] = false;
          if (_this.keysPressed[1]) {
            _this.lastKeyPressed = "right";
          } else {
            _this.lastKeyPressed = "none";
          }
        }
        if (event.keyCode === _this.player.keys[1]) {
          _this.keysPressed[1] = false;
          if (_this.keysPressed[0]) {
            return _this.lastKeyPressed = "left";
          } else {
            return _this.lastKeyPressed = "none";
          }
        }
      };
    }

    PlayerInstance.prototype.play = function() {
      this.updateCourse();
      this.updatePos();
      return this.updateBonus();
    };

    PlayerInstance.prototype.updatePos = function() {
      this.lastPos.x = this.pos.x;
      this.lastPos.y = this.pos.y;
      this.pos.x = this.pos.x + Math.cos(this.course) * this.radius;
      return this.pos.y = this.pos.y + Math.sin(this.course) * this.radius;
    };

    PlayerInstance.prototype.updateCourse = function() {
      var val;
      if (this.lastKeyPressed === "left") {
        val = -2 * Math.PI / 320;
      } else if (this.lastKeyPressed === "right") {
        val = 2 * Math.PI / 320;
      } else {
        val = 0;
      }
      this.course = this.course + val;
      if (this.course > 2 * Math.PI) {
        return this.course -= 2 * Math.PI;
      }
    };

    PlayerInstance.prototype.updateBonus = function() {
      var i, _results;
      i = 0;
      _results = [];
      while (i < this.bonuses.length) {
        if (this.bonuses[i].duration === 0) {
          _results.push(this.bonuses.splice(i, 1));
        } else {
          this.bonuses[i].play();
          _results.push(i++);
        }
      }
      return _results;
    };

    return PlayerInstance;

  })();

  Controller = (function() {

    function Controller() {
      this.bitmap = new Bitmap(800, 800, 20);
      this.painter = new Painter(this.bitmap);
      this.crashController = new CrashController(this);
      this.players = [new Player("Greenlee", "green", [79, 80]), new Player("Pinkney", "pink", [75, 76])];
    }

    Controller.prototype.notifyRoundIsDone = function() {
      var player, round, _i, _len, _ref;
      _ref = this.players;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        player = _ref[_i];
        if (player.score >= (this.players.length - 1) * 10) {
          return;
        }
      }
      round = new Round(this);
      return round.launch();
    };

    Controller.prototype.run = function() {
      var round;
      round = new Round(this);
      return round.launch();
    };

    return Controller;

  })();

  CrashController = (function() {

    CrashController.prototype.activeRound = null;

    function CrashController(controller) {
      this.controller = controller;
    }

    CrashController.prototype.setActiveRound = function(round) {
      return this.activeRound = round;
    };

    CrashController.prototype.checkForCrashes = function(player) {
      if (player.pos.x < this.controller.bitmap.boundariesWidth || player.pos.x > this.controller.bitmap.width - this.controller.bitmap.boundariesWidth || player.pos.y < this.controller.bitmap.boundariesWidth || player.pos.y > this.controller.bitmap.height - this.controller.bitmap.boundariesWidth) {
        return this.activeRound.notifyPlayerDeath(player);
      }
    };

    return CrashController;

  })();

  controller = new Controller();

  controller.run();

}).call(this);
