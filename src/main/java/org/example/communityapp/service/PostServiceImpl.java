package org.example.communityapp.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.example.communityapp.Exception.*;
import org.example.communityapp.domain.*;
import org.example.communityapp.mappers.PostMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;

@Service
@Transactional
@RequiredArgsConstructor
@Log4j2
public class PostServiceImpl implements PostService {

    private final PostMapper postMapper;

    @Override
    public List<PostListDTO> getPage(Criteria criteria) {
        return postMapper.getPage(criteria);
    }

    @Override
    public int getTotal(Criteria criteria) {
        return postMapper.getTotal(criteria);
    }

    @Override
    public PostDetailDTO getPostDetails(Long postId) {
        return postMapper.selectPostDetailById(postId).orElseThrow(() ->
                new ResourceNotFoundException("게시글", postId));
    }

    @Override
    public Long register(CreatePostRequestDTO createPostRequestDTO, String userId) {

        // 게시글 등록 -> 등록 안 되면 예외 발생
        PostVO postVO = new PostVO(
                createPostRequestDTO.getTitle(),
                createPostRequestDTO.getContent(),
                userId
        );

        if (postMapper.insertPost(postVO) != 1) {
            throw new PostCreationFailedException("게시글 등록에 실패했습니다.");
        }

        return postVO.getPostId();
    }

    @Override
    public PostModifyForm getModifyForm(Long postId, String userId) {
        // postId로 post 조회하여 없으면 예외
        PostModifyForm postModifyForm = postMapper.getModifyForm(postId).orElseThrow(() ->
                new ResourceNotFoundException("게시글", postId));

        // 조회한 Post의 작성자와 현재 사용자가 다르면 예외 발생
        if (!Objects.equals(userId, postModifyForm.getWriter())) {
            throw new NotResourceOwnerException("게시글", postId);
        }

        log.info("=====Service getModifyForm, postModifyForm={}", postModifyForm);

        return postModifyForm;
    }

    @Override
    public Long modify(ModifyPostRequestDTO modifyPostRequestDTO, Long postId, String userId) {

        // 게시글이 존재하지 않거나 소유자가 아니면 예외 발생
        PostVO found = postMapper.findById(postId).orElseThrow(() ->
                new ResourceNotFoundException("게시글", postId));
        if (!Objects.equals(userId, found.getWriter())) {
            throw new NotResourceOwnerException("게시글", postId);
        }

        // 게시글 수정 후 게시글 번호 반환 (수정 안 되면 예외 발생)
        PostVO postVO = PostVO.builder()
                .postId(postId)
                .title(modifyPostRequestDTO.getTitle())
                .content(modifyPostRequestDTO.getContent())
                .writer(userId)
                .build();

        if (postMapper.updatePost(postVO) != 1) {
            throw new PostModificationFailedException("게시글 수정에 실패했습니다.");
        }
        return postVO.getPostId();
    }

    @Override
    public void remove(Long postId, String userId) {
        // 게시글이 존재하지 않거나 소유자가 아니면 예외 발생
        String writerOfPost = postMapper.selectWriterByPostId(postId);
        if (writerOfPost == null) {
            throw new ResourceNotFoundException("게시글", postId);
        }
        if (!Objects.equals(userId, writerOfPost)) {
            throw new NotResourceOwnerException("게시글", postId);
        }

        if (postMapper.deletePostByIdAndUserId(postId, userId) != 1) {
            throw new PostRemoveFailedException("게시글 삭제에 실패했습니다.");
        }
    }
}
