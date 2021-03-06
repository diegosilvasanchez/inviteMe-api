package br.com.application.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.application.entity.State;

@Repository
public interface StateRepository extends JpaRepository<State, Integer>{

}
