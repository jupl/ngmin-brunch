## ngmin-brunch 1.7.0

[<img src="https://david-dm.org/jupl/ngmin-brunch.png"/>](https://david-dm.org/jupl/ngmin-brunch)
[<img src="https://david-dm.org/jupl/ngmin-brunch/dev-status.png"/>](https://david-dm.org/jupl/ngmin-brunch#info=devDependencies)

Use [ngmin](https://github.com/btford/ngmin) to run through AngularJS code and turn function styles dependency injection annotations into array style annotations for minifiers. For instance, convert

```javascript
angular.module('app').controller('MyCtrl', function($http) {
  ...
});
```

into

```javascript
angular.module('app').controller('MyCtrl', [
  '$http',
  function($http) {
    ...
  }
]);
```


## Usage
Add `"ngmin-brunch": "x.y.z"` to `package.json` of your brunch app.

Pick a plugin version that corresponds to your minor (y) brunch version.

If you want to use git version of plugin, add
`"ngmin-brunch": "git+ssh://git@github.com:jupl/ngmin-brunch.git"`.
