'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

const LiveActivity = core.registerPlugin('LiveActivity', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.LiveActivityWeb()),
});

class LiveActivityWeb extends core.WebPlugin {
    async echo(options) {
        console.log('ECHO', options);
        return options;
    }
    async start(options) {
        console.log('ECHO', options);
        return { activityId: '' };
    }
    async update(options) {
        console.log('ECHO', options);
        return;
    }
    async stop(options) {
        console.log('ECHO', options);
        return;
    }
}

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    LiveActivityWeb: LiveActivityWeb
});

exports.LiveActivity = LiveActivity;
//# sourceMappingURL=plugin.cjs.js.map
