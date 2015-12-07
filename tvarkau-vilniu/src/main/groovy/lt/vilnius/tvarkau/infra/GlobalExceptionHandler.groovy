package lt.vilnius.tvarkau.infra

import org.springframework.dao.DataIntegrityViolationException
import org.springframework.web.bind.annotation.ControllerAdvice
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.ResponseStatus

import static org.springframework.http.HttpStatus.CONFLICT

@ControllerAdvice
class GlobalExceptionHandler {

    @ResponseStatus(CONFLICT)
    @ExceptionHandler(DataIntegrityViolationException)
    void conflict() {}
}
