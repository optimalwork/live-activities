export interface LiveActivityPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
    start(options: {
        name: string;
        timerType?: string;
        emoji: string;
        expectedTimeInSeconds: number;
    }): Promise<{
        activityId: string;
    }>;
    update(options: {
        activityId: string;
        emoji: string;
        expectedTimeInSeconds: number;
        /** When true, the widget renders a static "Paused" state instead of a counting-down timer. */
        isPaused?: boolean;
        /** Frozen remaining seconds to display when `isPaused` is true. */
        secondsRemainingAtPause?: number;
        /** Whether to fire a system alert (banner/sound) on this update. Defaults to false. */
        notify?: boolean;
    }): Promise<void>;
    stop(options: {
        activityId: string;
    }): Promise<void>;
}
