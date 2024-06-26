package com.example.faculdade_progressus.service;

import com.example.faculdade_progressus.models.Curso;
import com.example.faculdade_progressus.repository.CursoRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CursoService {
    @Autowired
    private CursoRepository cursoRepository;

    public List<Curso> findAll() {
        return cursoRepository.findAll();
    }

    public Curso findById(Long id) {
        return cursoRepository.findById(id).orElse(null);
    }

    @Transactional
    public Curso save(Curso curso) {
        return cursoRepository.save(curso);
    }

    @Transactional
    public void deleteById(Long id) {
        cursoRepository.deleteById(id);
    }
}
