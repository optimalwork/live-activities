# live-activities

Live Activity Integration for iOS

## Install

```bash
npm install live-activities
npx cap sync
```

## Custom Icon

The Live Activity and Dynamic Island views display an app icon. You must provide your own image named `live-activity-icon` in your widget extension's asset catalog.

### Setup

1. In Xcode, open your widget extension's asset catalog at `ios/App/Timer/Assets.xcassets/`.
2. Create a new Image Set named **`live-activity-icon`**.
3. Add your icon at the following sizes (for a 48pt frame):

| Scale | Pixels    |
|-------|-----------|
| 1x    | 48 x 48   |
| 2x    | 96 x 96   |
| 3x    | 144 x 144  |

If no `live-activity-icon` image is found, a system `timer` icon is shown as a fallback.

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`start(...)`](#start)
* [`update(...)`](#update)
* [`stop(...)`](#stop)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### start(...)

```typescript
start(options: { name: string; timerType?: string; emoji: string; expectedTimeInSeconds: number; }) => Promise<{ activityId: string; }>
```

| Param         | Type                                                                                             |
| ------------- | ------------------------------------------------------------------------------------------------ |
| **`options`** | <code>{ name: string; timerType?: string; emoji: string; expectedTimeInSeconds: number; }</code> |

**Returns:** <code>Promise&lt;{ activityId: string; }&gt;</code>

--------------------


### update(...)

```typescript
update(options: { activityId: string; emoji: string; expectedTimeInSeconds: number; }) => Promise<void>
```

| Param         | Type                                                                               |
| ------------- | ---------------------------------------------------------------------------------- |
| **`options`** | <code>{ activityId: string; emoji: string; expectedTimeInSeconds: number; }</code> |

--------------------


### stop(...)

```typescript
stop(options: { activityId: string; }) => Promise<void>
```

| Param         | Type                                 |
| ------------- | ------------------------------------ |
| **`options`** | <code>{ activityId: string; }</code> |

--------------------

</docgen-api>
