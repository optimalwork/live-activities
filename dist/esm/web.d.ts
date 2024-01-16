import { WebPlugin } from '@capacitor/core';
import type { LiveActivityPlugin } from './definitions';
export declare class LiveActivityWeb extends WebPlugin implements LiveActivityPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
    start(options: {
        name: string;
        emoji: string;
        expectedTimeInSeconds: number;
    }): Promise<{
        activityId: string;
    }>;
    update(options: {
        emoji: string;
        expectedTimeInSeconds: number;
        activityId: string;
    }): Promise<void>;
    stop(options: {
        activityId: string;
    }): Promise<void>;
}
