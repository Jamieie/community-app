package org.example.communityapp.Exception;

public class CommentCreationFailedException extends RuntimeException {
    public CommentCreationFailedException(String message) {
        super(message);
    }
}
