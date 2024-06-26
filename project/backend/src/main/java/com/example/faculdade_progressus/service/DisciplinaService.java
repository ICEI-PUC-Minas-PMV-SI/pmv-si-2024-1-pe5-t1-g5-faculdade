package com.example.faculdade_progressus.service;

import com.example.faculdade_progressus.models.Curso;
import com.example.faculdade_progressus.models.Disciplina;
import com.example.faculdade_progressus.repository.DisciplinaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DisciplinaService {

    @Autowired
    private DisciplinaRepository disciplinaRepository;

    @Autowired
    private CursoService cursoService;

    public List<Disciplina> findAll() {
        return disciplinaRepository.findAll();
    }

    public Optional<Disciplina> findById(Long id) {
        return disciplinaRepository.findById(id);
    }

    public Disciplina save(Disciplina disciplina) {
        Curso curso = cursoService.findById(disciplina.getCurso().getId());
        disciplina.setCurso(curso);
        return disciplinaRepository.save(disciplina);
    }

    public void delete(Disciplina disciplina) {
        disciplinaRepository.delete(disciplina);
    }
}
