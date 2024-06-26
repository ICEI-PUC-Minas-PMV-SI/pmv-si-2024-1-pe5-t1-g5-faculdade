package com.example.faculdade_progressus.service;

import com.example.faculdade_progressus.models.Matricula;
import com.example.faculdade_progressus.repository.MatriculaRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MatriculaService {
    @Autowired
    private MatriculaRepository matriculaRepository;

    public List<Matricula> findAll() {
        return matriculaRepository.findAll();
    }

    public Matricula findById(Long id) {
        return matriculaRepository.findById(id).orElse(null);
    }

    @Transactional
    public Matricula save(Matricula matricula) {
        return matriculaRepository.save(matricula);
    }

    @Transactional
    public void deleteById(Long id) {
        matriculaRepository.deleteById(id);
    }
}
