import { WebPlugin } from '@capacitor/core';
export class LiveActivityWeb extends WebPlugin {
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
//# sourceMappingURL=web.js.map