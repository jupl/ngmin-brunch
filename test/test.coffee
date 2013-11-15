Plugin = require('../src')
angular = spies = null

describe 'Plugin', ->

  beforeEach ->
    @plugin = new Plugin
    angular = module: -> spies
    spies =
      config: sinon.spy(-> spies)
      controller: sinon.spy(-> spies)
      directive: sinon.spy(-> spies)
      factory: sinon.spy(-> spies)
      filter: sinon.spy(-> spies)
      service: sinon.spy(-> spies)
      run: sinon.spy(-> spies)

  it 'should be an object', ->
    expect(@plugin).to.be.ok

  it 'should have a #optimize method', ->
    expect(@plugin.optimize).to.be.an.instanceof(Function)

  it 'should optimize config', (done) ->
    content = """
      angular.module('app').config(function($routeProvider, $locationProvider) {});
    """
    @plugin.optimize content, 'app/path.js', (error, data) ->
      expect(error).not.to.be.ok
      eval(data)
      expect(spies.config).to.be.calledOnce
      [args] = spies.config.args
      expect(args).to.have.length(1)
      expect(args[0]).to.be.an('array')
      expect(args[0][0]).to.equal('$routeProvider')
      expect(args[0][1]).to.equal('$locationProvider')
      expect(args[0][2]).to.be.a('function')
      done()

  it 'should optimize controller', (done) ->
    content = """
      angular.module('app').controller('MyCtrl', function($scope, $rootScope) {});
    """
    @plugin.optimize content, 'app/path.js', (error, data) ->
      expect(error).not.to.be.ok
      eval(data)
      expect(spies.controller).to.be.calledOnce
      [args] = spies.controller.args
      expect(args).to.have.length(2)
      expect(args[1]).to.be.an('array')
      expect(args[1][0]).to.equal('$scope')
      expect(args[1][1]).to.equal('$rootScope')
      expect(args[1][2]).to.be.a('function')
      done()

  it 'should optimize directive', (done) ->
    content = """
      angular.module('app').directive('myDirective', function($templateCache) {});
    """
    @plugin.optimize content, 'app/path.js', (error, data) ->
      expect(error).not.to.be.ok
      eval(data)
      expect(spies.directive).to.be.calledOnce
      [args] = spies.directive.args
      expect(args).to.have.length(2)
      expect(args[1]).to.be.an('array')
      expect(args[1][0]).to.equal('$templateCache')
      expect(args[1][1]).to.be.a('function')
      done()

  it 'should optimize factory', (done) ->
    content = """
      angular.module('app').factory('myFactory', function(someService, someOtherService) {});
    """
    @plugin.optimize content, 'app/path.js', (error, data) ->
      expect(error).not.to.be.ok
      eval(data)
      expect(spies.factory).to.be.calledOnce
      [args] = spies.factory.args
      expect(args).to.have.length(2)
      expect(args[1]).to.be.an('array')
      expect(args[1][0]).to.equal('someService')
      expect(args[1][1]).to.equal('someOtherService')
      expect(args[1][2]).to.be.a('function')
      done()

  it 'should optimize filter', (done) ->
    content = """
      angular.module('app').filter('myFilter', function($http) {});
    """
    @plugin.optimize content, 'app/path.js', (error, data) ->
      expect(error).not.to.be.ok
      eval(data)
      expect(spies.filter).to.be.calledOnce
      [args] = spies.filter.args
      expect(args).to.have.length(2)
      expect(args[1]).to.be.an('array')
      expect(args[1][0]).to.equal('$http')
      expect(args[1][1]).to.be.a('function')
      done()

  it 'should optimize service', (done) ->
    content = """
      angular.module('app').service('myService', function(aFactory, aService) {});
    """
    @plugin.optimize content, 'app/path.js', (error, data) ->
      expect(error).not.to.be.ok
      eval(data)
      expect(spies.service).to.be.calledOnce
      [args] = spies.service.args
      expect(args).to.have.length(2)
      expect(args[1]).to.be.an('array')
      expect(args[1][0]).to.equal('aFactory')
      expect(args[1][1]).to.equal('aService')
      expect(args[1][2]).to.be.a('function')
      done()

  it 'should optimize with chaining', (done) ->
    content = """
      angular.module('app').config(function($provider) {}).run(function($rootScope) {});
    """
    @plugin.optimize content, 'app/path.js', (error, data) ->
      expect(error).not.to.be.ok
      eval(data)
      expect(spies.config).to.be.calledOnce
      expect(spies.run).to.be.calledOnce
      expect(spies.config).to.be.calledBefore(spies.run)
      [args] = spies.config.args
      expect(args).to.have.length(1)
      expect(args[0]).to.be.an('array')
      expect(args[0][0]).to.equal('$provider')
      expect(args[0][1]).to.be.a('function')
      [args] = spies.run.args
      expect(args).to.have.length(1)
      expect(args[0]).to.be.an('array')
      expect(args[0][0]).to.equal('$rootScope')
      expect(args[0][1]).to.be.a('function')
      done()
