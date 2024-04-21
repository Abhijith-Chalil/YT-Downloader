/// Represents the different statuses that can occur during an API request.
/// - `initial`: The initial state before any API request is made.
/// - `loading`: The state when an API request is in progress.
/// - `completed`: The state when an API request has completed successfully.
/// - `error`: The state when an API request has encountered an error.
enum ApiStatus { initial, loading, completed, error }
