-dontwarn com.google.j2objc.annotations.ReflectionSupport
# Adicione as regras de manutenção geradas pelo R8
-keep class com.google.j2objc.annotations.ReflectionSupport { *; }
-keep class com.google.common.util.concurrent.AbstractFuture { *; }