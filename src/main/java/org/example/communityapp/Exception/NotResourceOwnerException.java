package org.example.communityapp.Exception;

public class NotResourceOwnerException extends RuntimeException {
    public NotResourceOwnerException(String resourceName, Object key) {
        super(resourceName + "의 작성자가 아닙니다. id=" + key);
    }

    public NotResourceOwnerException(String message) {
        super(message);
    }
}
