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
echo(options: { value: string; }) => any
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>any</code>

--------------------


### start(...)

```typescript
start(options: { name: string; emoji: string; expectedTimeInSeconds: number; }) => any
```

| Param         | Type                                                                         |
| ------------- | ---------------------------------------------------------------------------- |
| **`options`** | <code>{ name: string; emoji: string; expectedTimeInSeconds: number; }</code> |

**Returns:** <code>any</code>

--------------------


### update(...)

```typescript
update(options: { activityId: string; emoji: string; expectedTimeInSeconds: number; }) => any
```

| Param         | Type                                                                               |
| ------------- | ---------------------------------------------------------------------------------- |
| **`options`** | <code>{ activityId: string; emoji: string; expectedTimeInSeconds: number; }</code> |

**Returns:** <code>any</code>

--------------------


### stop(...)

```typescript
stop(options: { activityId: string; }) => any
```

| Param         | Type                                 |
| ------------- | ------------------------------------ |
| **`options`** | <code>{ activityId: string; }</code> |

**Returns:** <code>any</code>

--------------------

</docgen-api>
