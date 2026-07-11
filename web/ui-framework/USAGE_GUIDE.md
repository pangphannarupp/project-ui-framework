# @bizmob-core/ui-framework

## Screen List of All Components

This framework contains the following reusable UI components. 

### 1. `BizButton`
Standard button component.
- **Props**: `variant` (primary, secondary, danger), `block`, `disabled`

### 2. `BizInput`
Text input component with icon support.
- **Props**: `label`, `placeholder`, `type`, `clearable`
- **Slots**: `iconLeft`, `iconRight`

### 3. `BizPhoneInput`
Phone number input with country code dropdown.
- **Props**: `label`, `placeholder`, `countryCode`

### 4. `BizOtpInput`
OTP input blocks.
- **Props**: `length`
- **Events**: `@complete`

### 5. `BizInfoCard`
Informational alert box.
- **Props**: `type` (warning, info)

### 6. `BizActionCard`
Action center grid card.
- **Props**: `title`, `subtitle`, `badgeCount`, `badgeColor`
- **Slots**: `icon`

### 7. `BizAccountCard`
Account balance card.
- **Props**: `type` (deposit, loan), `count`, `balance`, `currency`, `isHidden`

### 8. `BizBottomNav`
Main bottom navigation.
- **Props**: `modelValue`, `items`
- **Events**: `@scan`

### 9. `BizCompanySelector`
Company selection header block.
- **Props**: `companyName`, `companyType`

### 10. `BizUserProfile`
User profile header block.
- **Props**: `userName`, `role`, `isVerified`

### 11. `BizIconButton`
Small icon button used in headers.
- **Props**: `color`, `badge`

### 12. `BizSegment` / `BizSegmentButton`
Toggle switches for tabs.
- **Props**: `value`
