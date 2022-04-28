$dartOut = "lib/src/messages"
$javaOut = "android/src/main/java"
$kotlinOut = "android/src/main/kotlin"
$tails = "/com/additel/metis/scanner/messages"
$javaDirectory = "$javaOut$tails"
$kotlinDirectory = "$kotlinOut$tails"
if (Test-Path $dartOut) {
    Get-ChildItem $dartOut | Remove-Item -Recurse
}
else {
    New-Item $dartOut -ItemType Directory
}
if (Test-Path $javaDirectory) {
    Remove-Item $javaDirectory -Recurse
}
if (Test-Path $kotlinDirectory) {
    Remove-Item $kotlinDirectory -Recurse
}
protoc --dart_out $dartOut --java_out $javaOut --kotlin_out $kotlinOut messages.proto
dart format $dartOut