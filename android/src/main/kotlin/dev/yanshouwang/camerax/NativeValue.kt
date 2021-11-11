package dev.yanshouwang.camerax

import java.util.*

open class NativeValue<T>(val value: T) {
    val key = UUID.randomUUID().toString()
}