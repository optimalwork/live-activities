export interface LiveActivityPlugin {
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
        activityId: string;
        emoji: string;
        expectedTimeInSeconds: number;
    }): Promise<void>;
    stop(options: {
        activityId: string;
    }): Promise<void>;
}
