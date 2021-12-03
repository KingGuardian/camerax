package dev.yanshouwang.camerax

import java.util.*

open class IndexedObject<T>(val value: T) {
    val uuid = UUID.randomUUID().toString()
}