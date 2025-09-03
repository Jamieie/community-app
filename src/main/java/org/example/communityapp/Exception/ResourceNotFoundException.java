package org.example.communityapp.Exception;

public class ResourceNotFoundException extends RuntimeException {
    public ResourceNotFoundException(String resourceName, Object key) {
        super(resourceName + "을(를) 찾을 수 없습니다. : id=" + key);
    }

    public ResourceNotFoundException(String message) {
        super(message);
    }
}
