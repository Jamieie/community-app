package org.example.communityapp.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.communityapp.domain.*;
import org.example.communityapp.service.PostService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/posts")
@RequiredArgsConstructor
@Slf4j
public class PostController {

    private final PostService postService;

    @GetMapping
    public String getPosts(@ModelAttribute Criteria criteria, Model model) {
        List<PostListDTO> posts = postService.getPage(criteria);
        model.addAttribute("posts", posts);
        PageDTO pageDTO = new PageDTO(criteria, postService.getTotal(criteria));
        model.addAttribute("pageMaker", pageDTO);
        return "/posts/list";
    }

    @GetMapping("/{postId:\\d+}")
    public String getPostDetail(@PathVariable("postId") Long postId, Model model) {

        PostDetailDTO post = postService.getPostDetails(postId);
        model.addAttribute("post", post);
        return "/posts/detail";
    }

    @GetMapping("/register")
    public String registerForm() {
        return "/posts/register";
    }

    @PostMapping("/register")
    public String register(@AuthenticationPrincipal CustomUserDetails user,
                           @Valid @ModelAttribute CreatePostRequestDTO createPostRequestDTO) {

        // userId와 게시글 생성 데이터 함께 전달하여 게시글 생성
        String userId = user.getUserId();
        Long postId = postService.register(createPostRequestDTO, userId);

        // 생성된 게시글의 id 받아와서 조회하는 페이지로 리다이렉트
        return "redirect:/posts/" + postId;
    }

    @GetMapping("/{postId:\\d+}/modify")
    public String modifyForm(@PathVariable("postId") Long postId,
                             @AuthenticationPrincipal CustomUserDetails user,
                             Model model) {

        PostModifyForm modifyForm = postService.getModifyForm(postId, user.getUserId());
        model.addAttribute("post", modifyForm);

        log.info("=====Controller ModifyForm, modifyForm={}", modifyForm);

        return "/posts/modify";
    }

    @PostMapping("/{postId:\\d+}/modify")
    public String modify(@PathVariable("postId") Long postId,
                         @Valid @ModelAttribute ModifyPostRequestDTO modifyPostRequestDTO,
                         @AuthenticationPrincipal CustomUserDetails user) {

        Long modifiedPostId = postService.modify(modifyPostRequestDTO, postId, user.getUserId());
        return "redirect:/posts/" + modifiedPostId;
    }

    @PostMapping("/{postId:\\d+}/remove")
    public String remove(@PathVariable("postId") Long postId,
                         @AuthenticationPrincipal CustomUserDetails user) {

        postService.remove(postId, user.getUserId());
        return "redirect:/posts";
    }
}
