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
    /**
     * End EVERY activity this app owns, immediately. Cold-start orphan
     * recovery: a Live Activity outlives the webview, so a killed/reloaded
     * session can leave one running with no JS owner (and no reachable id) —
     * call this at app boot, when nothing legitimately owns an activity yet.
     */
    stopAll(): Promise<void>;
}
