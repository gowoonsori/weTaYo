package wetayo.wetayoapi.exceptions;

import graphql.GraphQLError;
import graphql.GraphQLException;
import graphql.kickstart.execution.error.GraphQLErrorHandler;
import graphql.validation.ValidationError;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.stream.Collectors;

@Component
@Slf4j
public class GraphQLErrorHandlerImpl implements GraphQLErrorHandler {

    @Override
    public List<GraphQLError> processErrors(List<GraphQLError> graphQLErrors) {
        return graphQLErrors.stream().map(this::handleGraphQLError).collect(Collectors.toList());
    }

    private GraphQLError handleGraphQLError(GraphQLError error) {
        if (error instanceof GraphQLException) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "GraphQLException as GraphQLError...", (GraphQLException) error);
        } else if (error instanceof ValidationError){
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "ValidationError: " + error.getMessage());
        } else {
            log.error("SQL Exception", error);
            return error;
        }
    }
}
