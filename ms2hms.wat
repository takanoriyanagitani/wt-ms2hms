(module

  (func $ms2hms (export "ms2hms")
    (param $relms i32)
    (result
      i32 ;; hours
      i32 ;; minutes
      i32 ;; seconds
      i32 ;; ms
    )

    (local $tot_seconds i32)
    (local $tot_minutes i32)
    (local $tot_hours   i32)

    ;; extract total seconds
    local.get $relms
    i64.extend_i32_u
    i64.const 274877907
    i64.mul
    i64.const 38
    i64.shr_u
    i32.wrap_i64
    local.tee $tot_seconds

    ;; extract total minutes
    i64.extend_i32_u
    i64.const 1145324613
    i64.mul
    i64.const 36
    i64.shr_u
    i32.wrap_i64
    local.tee $tot_minutes

    ;; extract total hours
    i64.extend_i32_u
    i64.const 1145324613
    i64.mul
    i64.const 36
    i64.shr_u
    i32.wrap_i64
    local.tee $tot_hours

    ;; extract minutes
    local.get $tot_minutes
    local.get $tot_hours
    i32.const 60
    i32.mul
    i32.sub

    ;; extract seconds
    local.get $tot_seconds
    local.get $tot_minutes
    i32.const 60
    i32.mul
    i32.sub

    ;; extract ms
    local.get $relms
    local.get $tot_seconds
    i32.const 1000
    i32.mul
    i32.sub
  )

  (func $ms2hms_packed (export "ms2hms_packed") (param $relms i32) (result i32)

    (local $tot_seconds i32)
    (local $tot_minutes i32)
    (local $tot_hours   i32)

    ;; extract total seconds
    local.get $relms
    i64.extend_i32_u
    i64.const 274877907
    i64.mul
    i64.const 38
    i64.shr_u
    i32.wrap_i64
    local.tee $tot_seconds

    ;; extract total minutes
    i64.extend_i32_u
    i64.const 1145324613
    i64.mul
    i64.const 36
    i64.shr_u
    i32.wrap_i64
    local.tee $tot_minutes

    ;; extract total hours
    i64.extend_i32_u
    i64.const 1145324613
    i64.mul
    i64.const 36
    i64.shr_u
    i32.wrap_i64
    local.tee $tot_hours

    ;; pack hour
    i32.const 22
    i32.shl

    ;; pack minute
    local.get $tot_minutes
    local.get $tot_hours
    i32.const 60
    i32.mul
    i32.sub
    i32.const 16
    i32.shl

    ;; pack hour & minute
    i32.or

    ;; pack second
    local.get $tot_seconds
    local.get $tot_minutes
    i32.const 60
    i32.mul
    i32.sub
    i32.const 10
    i32.shl

    ;; pack hour & minute & second
    i32.or

    ;; pack ms
    local.get $relms
    local.get $tot_seconds
    i32.const 1000
    i32.mul
    i32.sub
    i32.or
  )
)
