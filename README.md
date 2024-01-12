# live-activities

Live Activity Integration for iOS

## Install

```bash
npm install live-activities
npx cap sync
```

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
start(options: { name: string; emoji: string; expectedTimeInSeconds: number; }) => Promise<{ activityId: string; }>
```

| Param         | Type                                                                         |
| ------------- | ---------------------------------------------------------------------------- |
| **`options`** | <code>{ name: string; emoji: string; expectedTimeInSeconds: number; }</code> |

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
