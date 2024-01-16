import { registerPlugin } from '@capacitor/core';
const LiveActivity = registerPlugin('LiveActivity', {
    web: () => import('./web').then(m => new m.LiveActivityWeb()),
});
export * from './definitions';
export { LiveActivity };
//# sourceMappingURL=index.js.map