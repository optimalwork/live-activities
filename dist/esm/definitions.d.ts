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
        /** When true, the widget renders a "Paused" state — static unless `fixedEnd` is also true. */
        isPaused?: boolean;
        /** Frozen remaining seconds to display when `isPaused` is true (ignored when `fixedEnd`). */
        secondsRemainingAtPause?: number;
        /**
         * Fixed-end-time session: the deadline is a wall-clock stop, so a paused
         * timer KEEPS counting down (pause stops the app's work logging, not the
         * clock). The widget shows the "Paused" caption over a live countdown,
         * and still flips to "Time's up" at zero.
         */
        fixedEnd?: boolean;
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
