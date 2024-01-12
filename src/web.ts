import { WebPlugin } from '@capacitor/core';

import type { LiveActivityPlugin } from './definitions';

export class LiveActivityWeb extends WebPlugin implements LiveActivityPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async start(options: {
    name: string;
    emoji: string;
    expectedTimeInSeconds: number;
  }): Promise<{ activityId: string }> {
    console.log('ECHO', options);
    return { activityId: '' };
  }

  async update(options: {
    emoji: string;
    expectedTimeInSeconds: number;
    activityId: string;
  }): Promise<void> {
    console.log('ECHO', options);
    return;
  }

  async stop(options: { activityId: string }): Promise<void> {
    console.log('ECHO', options);
    return;
  }
}
