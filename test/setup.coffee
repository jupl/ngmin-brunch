sinon = require('sinon')
chai = require('chai')
sinonChai = require('sinon-chai')

chai.use(sinonChai)
global.sinon = sinon
global.expect = chai.expect
