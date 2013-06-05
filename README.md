# Komodo

Komodo is a dead simple tool for managing Heroku processes in Node.js. This module has been updated to use the [Heroku Platform API](https://devcenter.heroku.com/articles/platform-api-reference) as of the 0.2 release.

## Installation

Install via npm:

    $ npm install komodo

## Example

    var komodo = require('komodo')('YOUR_API_KEY', 'YOUR_APP_NAME')

    // Scale the web process to 5 dynos
    komodo.scale({type: 'web', quantity: 5}), function (err, data) {
      return console.log(data);
    });

    // List all processes
    komodo.list(function (err, data) {
      return console.log(data);
    });

    // Stop a process type
    komodo.stop({type: 'web'}), function (err, data) {
      return console.log(data);
    });

## API

#### komodo.scale(options, callback)

Scales a process to the specified number of dynos.

##### Options: 

* `type`: The name of the process to scale.
* `quantity`: The number of dynos to scale to.
* `size`: The dyno size to use. Defaults to 1.

#### komodo.stop(options, callback)

Stop process type. One of the options below must be specified:

##### Options: 

* `type`: The name of the process to stop.

#### komodo.list(callback)

List all process types.

## Running the tests

To run the test suite, create a file in the root of the module directory
named `heroku_config.json` and fill it out with an api key and application
to test with:

    {
      "key": "YOUR_API_KEY",
      "app": "YOUR_APP"
    }

Note that the applicaiton you specify will have it's processes scaled up, then
to 1 and fianlly restarted. It is not advisable to use a production application
for testing. Once the configuration file is set up, run these commands:

    $ npm install
    $ npm test

## License

(The MIT License)

Copyright (c) 2013 Charles Moncrief <<cmoncrief@gmail.com>>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.