export class ApiError extends Error {
  status: number;
  body: unknown;

  constructor(message: string, status: number, body: unknown) {
    super(message);
    this.status = status;
    this.body = body;
  }
}

export async function apiGet<T>(path: string): Promise<T> {
  const res = await fetch(path, {
    headers: { 'Accept': 'application/json' }
  });

  const text = await res.text();
  const body = text ? safeJson(text) : null;

  if (!res.ok) {
    const msg =
      (body && typeof body === 'object' && body !== null && 'message' in body && typeof (body as {message: string}).message === 'string')
        ? (body as {message: string}).message
        : `Request failed: ${res.status}`;
    throw new ApiError(msg, res.status, body);
  }

  return body as T;
}

function safeJson(text: string) {
  try {
    return JSON.parse(text);
  } catch {
    return text;
  }
}
