package org.example.communityapp.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.example.communityapp.domain.Criteria;
import org.example.communityapp.domain.PageDTO;
import org.example.communityapp.domain.PostListDTO;
import org.example.communityapp.service.PostService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/posts")
@RequiredArgsConstructor
@Log4j2
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
}
